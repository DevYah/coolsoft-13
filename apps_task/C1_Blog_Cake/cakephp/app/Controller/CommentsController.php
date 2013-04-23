<?php
class CommentsController extends AppController{
  public $helpers = array('Html', 'Form', 'Session');
  public $components = array('Session');

  public function add($post_id) {
    if ($this->request->is('post')) {
      $this->Comment->create();
      $this->Comment->set("post_id", $post_id);
      $this->Comment->set("user_id", $this->Auth->user("id"));
      if ($this->Comment->save($this->request->data)) {
        $this->Session->setFlash('Your comment has been saved.');
        $this->redirect(array('controller' => 'posts', 'action' => 'view', $post_id));
      } else {
        $this->Session->setFlash('Unable to add your Comment.');
      }
    }
  }

  public function edit($id = null) {
    if (!$id) {
        throw new NotFoundException(__('Invalid comment'));
    }

    $post = $this->Comment->findById($id);
    if (!$post) {
        throw new NotFoundException(__('Invalid comment'));
    }

    if ($this->request->is('post') || $this->request->is('put')) {
        $this->Comment->id = $id;
        if ($this->Comment->save($this->request->data)) {
          
            $this->redirect(array("controller"=>"Posts", 'action' => 'view', $this->Comment->field("post_id")));
              $this->Session->setFlash('Your comment has been updated.');
        } else {
            $this->Session->setFlash('Unable to update your comment.');
        }
    }

    if (!$this->request->data) {
        $this->request->data = $post;
    }
}



    public function delete($id) {

      $this->Comment->id = $id;
      $this->Comment->delete($id);
      $this->redirect(array("controller" => "posts", "action" => "view", $this->Comment->field("post_id") ));
  }

}
?>
