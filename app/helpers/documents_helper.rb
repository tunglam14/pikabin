module DocumentsHelper
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

  EXPIRE = {
    '0'  => 'After reading',
    '-1' => 'No expire',
    '1m' => '1 min',
    '5m' => '5 min',
    '1h' => '1 hour',
    '1d' => '1 day'
  }

  def syntax_dropdown
    content_tag :div, class: "menu" do
      SYNTAX.each do |short, long|
        concat(content_tag :div, long, class: "item", :'data-value' => short)
      end
    end
  end

  def expired_at_dropdown
    content_tag :div, class: "menu" do
      EXPIRE.each do |short, long|
        concat(content_tag :div, long, class: "item", :'data-value' => short)
      end
    end
  end

  def print_document_title(document)
    if document.title.blank?
      return 'Unnamed document'
    end

    return document.title
  end

  def print_expired_at(document)
    expire = document.expired_at

    if expire == 0 or expire == '0' or expire.nil?
      return content_tag :div, class: "orange" do
        "Don't close this window, this document was removed"
      end
    end

    if expire == '-1'
      return content_tag :div, class: "" do
        "This document is immortal (:, you can delete it manually"
      end
    end

    begin
      return "This document will expire in <strong data-tooltip='#{expire}'>" \
      "<u>#{distance_of_time_in_words(Time.now, expire.to_datetime)}</u></strong>.".html_safe
    rescue Exception => e
    end
  end

  def load_syntax(document)
    document.syntax.capitalize
  end
end
