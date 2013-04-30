<?php
class Blog extends AppModel{
  public $hasMany = 'Post';
  public $belongsTo = 'User';
}
?>
