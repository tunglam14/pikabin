module DocumentsHelper
  def syntax_dropdown
    content_tag :div, class: "menu" do
      ACE_MODE.each do |syntax|
        concat(content_tag :div, syntax, class: "item", :'data-value' => syntax)
      end
      ACE_MODE_ALIAS.each do |fake, real|
        concat(content_tag :div, fake, class: "item", :'data-value' => real)
      end
    end
  end

  def expired_at_dropdown
    content_tag :div, class: "menu" do
      EXPIRE.each do |short, duration|
        concat(content_tag :div, duration['text'], class: "item", :'data-value' =>  duration['value'])
      end
    end
  end

  def tabsize_dropdown
    content_tag :div, class: "menu" do
      [2, 4, 8].each do |size|
        concat(content_tag :div, size, class: "item", :'data-value' =>  size)
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
    if ACE_MODE_ALIAS[document.syntax].nil?
      document.syntax
    else
      ACE_MODE_ALIAS[document.syntax]
    end
  end
end
