<?php
	class BlogsController extends AppController{
		public $helpers = array('Html', 'Form');
		public $components = array('Session');

		public function index(){
			$loggedin=0;
			$this->set('uid',$this->Auth->user('id'));
			if($this->Auth->user('id') == null){
				$loggedin = 0;
			}else{
				$loggedin = 1;
			}
			$this->set('loggedin', $loggedin);

			$blogs = $this->Blog->find('all');

			foreach ($blogs as &$blog){
				$blog['Blog']['user_name'] = $blog['User']['username'];
			}

			$this->set('blogs',$blogs);
		}


		public function view($id){

			$blog = $this->Blog->findById($id);
			$posts = $this->Blog->Post->findAllByBlog_id($id);

			foreach ($posts as &$post){
				$post['Post']['comment_count'] = $this->Blog->Post->Comment->find('count' , array('conditions' => array('Comment.post_id'=> $post['Post']['id'])));
			}
			
			$this->set('posts' , $posts);
			$this->set('blog' , $blog);
		}

		public function add() {
	
        	if ($this->request->is('post')) {
            	$this->Blog->create();
            	$this->Blog->set('user_id', $this->Auth->user("id"));
            if ($this->Blog->save($this->request->data)) {
                $this->Session->setFlash('Your blog has been saved.');
                $this->redirect(array('action' => 'index'));
            } else {
                $this->Session->setFlash('Unable to add your blog.');
            }
        }
    }
	
	}
?>