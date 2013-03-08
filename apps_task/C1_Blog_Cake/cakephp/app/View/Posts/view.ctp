<!-- File: /app/View/Posts/view.ctp -->

<h1><?php echo h($post['Post']['title']); ?></h1>

<p><small>Created: <?php echo $post['Post']['created']; ?></small></p>

<p><?php echo h($post['Post']['body']); ?></p>

<h1>Comments</h1>
<?php
if($loggedin==1){
echo $this->Form->create('Comment', array("controller" => "comments", "action" => "add/" . $post["Post"]["id"]));
echo $this->Form->input('content', array('rows' => '3'));
echo $this->Form->end('Add Comment');
}
?>

<div id="comments">
<?php foreach($post["Comment"] as $comment): ?>
<div class="comment">

     <span class="comment_user"><?php echo $comment["username"]; ?></span>
     <span> : </span>
  <?php echo $comment["content"]; ?>
  <span class="comment_date"><?php echo $comment["created"]; ?></span>
    
     <?php
     if($userid==$comment["user_id"]) {
     echo $this->Html->link("Edit", array("controller"=> "comments", "action"=> "edit", $comment["id"]));
     echo '     ';
     echo $this->Html->link("Delete", array("controller"=> "comments", "action"=> "delete", $comment["id"]));
     } ?>

<?php endforeach; ?>