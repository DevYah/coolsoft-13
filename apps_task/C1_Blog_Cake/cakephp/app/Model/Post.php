
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

  public $actsAs = array('Search.Searchable');

  public $filterArgs = array(
    'search' => array("field" => array("body", "title"), 'type' => 'like'));

  public function orConditions($data = array()) {
        $filter = $data['filter'];
        $cond = array(
            'OR' => array(
                $this->alias . '.title LIKE' => '%' . $filter . '%',
                $this->alias . '.body LIKE' => '%' . $filter . '%',
            ));
        return $cond;
    }
}
?>

