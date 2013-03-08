<?php
class Post extends AppModel{
  public $hasMany = 'Comment';
  public $belongsTo = 'Blog';
}
?>
