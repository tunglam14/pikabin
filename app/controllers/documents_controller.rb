class DocumentsController < ApplicationController
  # before_action :set_document, only: [:show, :destroy]
  before_action :validate_document, only: [:show, :destroy]

  # GET /documents/1
  # GET /documents/1.json
  def show
  end

  def new
    @document = Document.new
  end

  def create
    @document = Document.new(document_params)

    @res = {
      random_key: '',
      message: ''
    }

    respond_to do |format|
      if @document.save
        @res[:random_key] = "#{@document.friendly_id}-#{@document.password}"
        format.json { render :new, status: 201 }
      else
        format.json { render :new, status: 400 }
      end
    end
  end

  private
    def set_document
      token = parse_token
      @document = Document.find_by(friendly_id: token[:friendly_id])

      if not @document.nil?
        @document.password = token[:password]
      end
    end

    def document_params
      params.require(:document).permit(:content, :title, :syntax, :expired_at)
    end

    def parse_token
      begin
        token = params[:token].split('-')
        friendly_id = token[0]
        password    = token[1]
      rescue Exception => e
        friendly_id = nil
        password = nil
      end

      return {
        friendly_id: friendly_id,
        password: password
      }
    end

    # Check document
    def validate_document
      # binding.pry
      set_document

      if @document.nil? or @document.is_expired?
        Thread.new {
          @document.destroy rescue Rails.logger.info "Delete document fail"
        }
        redirect_to not_found_url
        return
      end
    end
end
