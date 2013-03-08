<?php 
    if($loggedin == 0){
        echo $this->Html->link('Signup' , array('controller' => 'users' , 'action' => 'add'));
        echo "   ";
        echo $this->Html->link('Login' , array('controller' => 'users' , 'action' => 'login')); 
    }else if($loggedin == 1){
        echo $this->Html->link('Logout' , array('controller' => 'users' , 'action' => 'logout'));
    }
?>
<h1>Blogs</h1>
<?php 
if($loggedin == 1){ 
    echo $this->Html->link('Add Blog' , array('controller' => 'blogs' , 'action' => 'add')); 
}?>
<?php if($loggedin==1): ?>
<table>
    <tr>
        <th>My Blogs</th>
    </tr>
    <?php foreach ($blogs as $blog): ?>
        <?php if($uid==$blog['Blog']['user_id']): ?>
    	<tr>
    		<td><?php  echo $this->Html->link($blog['Blog']['blog_name'] , array('controller' => 'posts' , 'action' => 'index', $blog['Blog']['id'])); ?></td>
    	</tr>
    <?php endif; ?>
    <?php endforeach; ?>
</table>
<?php endif; ?>
<table>
    <tr>
        <th>Blog Name</th>
        <th>Created By</th>
    </tr>
    <?php foreach ($blogs as $blog): ?>
    <?php if($uid!=$blog['Blog']['user_id']): ?>
        <tr>
            <td><?php  echo $this->Html->link($blog['Blog']['blog_name'] , array('controller' => 'blogs' , 'action' => 'view' , $blog['Blog']['id'])); ?></td>

            <td><?php echo $blog['Blog']['user_name']; ?></td>
        </tr>
     <?php endif; ?>   
    <?php endforeach; ?>

</table>