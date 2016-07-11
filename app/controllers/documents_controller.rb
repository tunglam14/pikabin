class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :destroy]

  rescue_from OpenSSL::Cipher::CipherError do |exception|
    message = "Decrypt fail #{params}"
    Rails.logger.error message
    redirect_to not_found_url
  end

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
      token: '',
      message: ''
    }

    respond_to do |format|
      if @document.save
        @res[:token] = TokenService.build(friendly_id: @document.friendly_id, password: @document.password)
        format.json { render :new, status: 201 }
      else
        format.json { render :new, status: 400 }
      end
    end
  end

  private
    def set_document
      token = parse_token
      @document = Document.find_and_validate_by_friendly_id(token[:friendly_id])

      if @document.nil?
        redirect_to not_found_url
        return
      end

      # Set password to decrypt
      @document.password = token[:password]
    end

    def document_params
      params.require(:document).permit(:content, :title, :syntax, :expired_at)
    end

    def parse_token
      TokenService.extract(token: params[:token])
    end
end
