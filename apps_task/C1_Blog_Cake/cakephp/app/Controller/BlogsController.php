<?php
	class BlogsController extends AppController{
		public $helpers = array('Html', 'Form');


		public function index(){

			$blogs = $this->Blog->find('all');
			

			foreach ($blogs as &$blog){
				$user = $this->Blog->User->findById($blog['Blog']['user_id']);
				$blog['Blog']['user_name'] = $user['User']['username'];
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
	
	}
?>