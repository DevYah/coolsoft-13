
<h3><?php echo h($blog['Blog']['blog_name']); ?></h3>

<?php foreach ($posts as $post): ?>
	<?php echo $this->Html->link($post['Post']['title'] , array('controller' => 'posts', 'action' => 'view', $post['Post']['id'])); ?>
	created on <?php echo $post['Post']['created'] ?>
	<br><br>
	<?php echo $post['Post']['body'] ?>
	<br><br>
	<?php echo $post['Post']['comment_count'] ?>  comments
	<br><br><br>
<?php endforeach; ?>