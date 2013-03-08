<?php
	class PostsController extends AppController{
		public $helpers = array('Html', 'Form');
		public $components = array('Session' , 'Search.Prg');
        public $presetVars = true;
        
		public function index($blogid){
        if($blogid==null){
            $this->redirect(array('controller'=>'blogs', 'action'=>'index'));
        }else{
		$this->set('posts' , $this->Post->findAllByBlog_id($blogid));
        $this->set('blogid', $blogid);
    }
	   }
    public function view($id = null) {
         $loggedin=0;
            $this->set('uid',$this->Auth->user('id'));
            if($this->Auth->user('id') == null){
                $loggedin = 0;
            }else{
                $loggedin = 1;
            }
            $this->set('loggedin', $loggedin);
            $this->set('postid', $id);     
            $this->set('userid',$this->Auth->user('id'));
        if (!$id) { 
            throw new NotFoundException(__('Invalid post'));
        }

        $post = $this->Post->findById($id);
        foreach($post['Comment'] as &$comment){
            $this->Post->Comment->User->id = $comment['user_id'];
            $comment['username'] = $this->Post->Comment->User->field("username");
        }
        if (!$post) {
            throw new NotFoundException(__('Invalid post'));
        }
        $this->set('post', $post);
    }
    public function add($blogid) {
	
        if ($this->request->is('post')) {
		
            $this->Post->create();
            $this->Post->set(array('blog_id' => $blogid));
            if ($this->Post->save($this->request->data)) {
                $this->Session->setFlash('Your post has been saved.');
                $this->redirect(array('action' => 'index', $blogid));
            } else {
                $this->Session->setFlash('Unable to add your post.');
            }
        }
    }
	public function edit($id = null, $blogid) {
    if (!$id) {
        throw new NotFoundException(__('Invalid post'));
    }

    $post = $this->Post->findById($id);
    if (!$post) {
        throw new NotFoundException(__('Invalid post'));
    }

    if ($this->request->is('post') || $this->request->is('put')) {
        $this->Post->id = $id;
        if ($this->Post->save($this->request->data)) {
            $this->Session->setFlash('Your post has been updated.');
            $this->redirect(array('action' => 'index', $blogid));
        } else {
            $this->Session->setFlash('Unable to update your post.');
        }
    }

    if (!$this->request->data) {
        $this->request->data = $post;
		}
    }
    public function delete($id, $blogid) {
        if($this->request->is('get')){
			throw new MethodNotAllowedException();
		}
		if($this->Post->delete($id)){
			$this->Session->setFlash('The post with id: ' .$id. ' has been deleted');
			$this->redirect(array('action' => 'index', $blogid));
		}
        
    }
       public function find() {
        $this->Prg->commonProcess();
        $this->paginate = array('conditions' => $this->Post->parseCriteria($this->passedArgs));
        $this->set('posts', $this->paginate());

    }
	}
?>