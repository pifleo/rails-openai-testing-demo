class Kb::DocumentsController < ApplicationController
  before_action :set_kb_document, only: %i[ show edit update destroy ]

  # GET /kb/documents or /kb/documents.json
  def index
    @kb_documents = Kb::Document.all
  end

  # GET /kb/documents/1 or /kb/documents/1.json
  def show
  end

  # GET /kb/documents/new
  def new
    @kb_document = Kb::Document.new
  end

  # GET /kb/documents/1/edit
  def edit
  end

  # POST /kb/documents or /kb/documents.json
  def create
    @kb_document = Kb::Document.new(kb_document_params)

    respond_to do |format|
      if @kb_document.save
        format.html { redirect_to kb_document_url(@kb_document), notice: "Document was successfully created." }
        format.json { render :show, status: :created, location: @kb_document }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @kb_document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /kb/documents/1 or /kb/documents/1.json
  def update
    respond_to do |format|
      if @kb_document.update(kb_document_params)
        format.html { redirect_to kb_document_url(@kb_document), notice: "Document was successfully updated." }
        format.json { render :show, status: :ok, location: @kb_document }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @kb_document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /kb/documents/1 or /kb/documents/1.json
  def destroy
    @kb_document.destroy!

    respond_to do |format|
      format.html { redirect_to kb_documents_url, notice: "Document was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_kb_document
      @kb_document = Kb::Document.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def kb_document_params
      params.require(:kb_document).permit(:name, :content, :file)
    end
end
