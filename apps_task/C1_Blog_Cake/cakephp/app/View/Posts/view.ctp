<!-- File: /app/View/Posts/view.ctp -->

<h1><?php echo h($post['Post']['title']); ?></h1>

<p><small>Created: <?php echo $post['Post']['created']; ?></small></p>

<p><?php echo h($post['Post']['body']); ?></p>



 <?php foreach ($comments as $comment): ?>
 <br>
    <tr>
        <td>
            <?php
			echo $comment['Comment']['content'] ?>
        </td>
		 <?php echo $this->Form->postLink(
                'Delete',
                array('controller'=>'Comments' , 'action' => 'delete', $comment['Comment']['id'] , $post['Post']['id']),
                array('confirm' => 'Are you sure?'));
            ?>
		
		
    </tr>
    <?php endforeach; ?>
	
	<br><br>
	
	<?php echo $this->Html->link('Add Comment', array('controller' => 'Comments' , 'action' => 'add' , $post['Post']['id'])); ?>