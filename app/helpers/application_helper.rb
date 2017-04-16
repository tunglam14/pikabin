module ApplicationHelper
  def page_title(document_title)
    title = 'PikaBin - Your friendly and secure PasteBin'

    return title if params[:action] == 'new' or params[:controller] == 'errors'

    title = if document_title
      "#{document_title} | #{title}"
    end

    return title
  end
end
