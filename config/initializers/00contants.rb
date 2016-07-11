SYNTAX = {
  'plain'      => 'Plain text',
  'python'     => 'Python',
  'ruby'       => 'Ruby',
  'jScript'    => 'Javascript',
  'bash'       => 'Bash/Shell',
  'perl'       => 'Perl',
  'xml'        => 'HTML',
  'css'        => 'CSS',
  'php'        => 'PHP'
}

# x * 60 (s)
EXPIRE = {
  '0'  => {
    'text' => 'After reading',
    'value' => 0
  },
  '-1' => {
    'text' => 'No expire',
    'value' => -1
  },
  '1m' => {
    'text' => '1 min',
    'value' => 1*60
  },
  '5m' => {
    'text' => '5 min',
    'value' => 5*60
  },
  '10m' => {
    'text' => '10 min',
    'value' => 10*60
  },
  '1h' => {
    'text' => '1 hour',
    'value' =>  1*60*60
  },
  '1d' => {
    'text' => '1 day',
    'value' => 24*60*60
  }
}
