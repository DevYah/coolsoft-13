
<!-- File: /app/View/Blogs/add.ctp -->

<h1>Add Post</h1>
<?php
echo $this->Form->create('Blog');
echo $this->Form->input('blog_name');
echo $this->Form->end('Add Blog');

?>