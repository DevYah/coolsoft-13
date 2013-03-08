<?php
class Post extends AppModel{
  public $hasMany = 'Comment';
  public $belongsTo = 'Blog';

  public $validate = array(
        'title' => array(
            'rule' => 'notEmpty'
        ),
        'body' => array(
            'rule' => 'notEmpty'
        )
    );
}
?>
