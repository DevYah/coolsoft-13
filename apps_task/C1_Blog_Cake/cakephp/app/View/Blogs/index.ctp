<h1>Blogs</h1>
<table>
    <tr>
        <th>Blog Name</th>
        <th>Created By</th>
    </tr>

    <?php foreach ($blogs as $blog): ?>
    	<tr>
    		<td><?php echo $this->Html->link($blog['Blog']['blog_name'] , array('controller' => 'blogs' , 'action' => 'view' , $blog['Blog']['id'])); ?></td>

    		<td><?php echo $blog['Blog']['user_name']; ?></td>
    	</tr>
    <?php endforeach; ?>

</table>
