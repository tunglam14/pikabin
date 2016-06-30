module DocumentsHelper
  SYNTAX = {
    'plain_text' => 'Plain text',
    'html'       => 'HTML',
    'python'     => 'Python',
    'ruby'       => 'Ruby',
    'javascript' => 'Javascript'
  }

  EXPIRE = {
    '0'  => 'After reading',
    '1m' => '1m',
    '2m' => '2m',
    '3m' => '3m'
  }

  def syntax_dropdown
    content_tag :div, class: "menu" do
      SYNTAX.each do |short, long|
        concat(content_tag :div, long, class: "item", :'data-value' => short)
      end
    end
  end

  def expire_dropdown
    content_tag :div, class: "menu" do
      EXPIRE.each do |short, long|
        concat(content_tag :div, long, class: "item", :'data-value' => short)
      end
    end
  end
end
