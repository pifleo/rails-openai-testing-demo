class Kb::PagesController < ApplicationController
  before_action :set_kb_page, only: %i[ show edit update destroy ]

  # GET /kb/pages or /kb/pages.json
  def index
    @kb_pages = Kb::Page.all
  end

  # GET /kb/pages/1 or /kb/pages/1.json
  def show
  end

  # GET /kb/pages/new
  def new
    @kb_page = Kb::Page.new
  end

  # GET /kb/pages/1/edit
  def edit
  end

  # POST /kb/pages or /kb/pages.json
  def create
    @kb_page = Kb::Page.new(kb_page_params)

    respond_to do |format|
      if @kb_page.save
        format.html { redirect_to kb_page_url(@kb_page), notice: "Page was successfully created." }
        format.json { render :show, status: :created, location: @kb_page }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @kb_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /kb/pages/1 or /kb/pages/1.json
  def update
    respond_to do |format|
      if @kb_page.update(kb_page_params)
        format.html { redirect_to kb_page_url(@kb_page), notice: "Page was successfully updated." }
        format.json { render :show, status: :ok, location: @kb_page }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @kb_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /kb/pages/1 or /kb/pages/1.json
  def destroy
    @kb_page.destroy!

    respond_to do |format|
      format.html { redirect_to kb_pages_url, notice: "Page was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_kb_page
      @kb_page = Kb::Page.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def kb_page_params
      params.require(:kb_page).permit(:document_id, :page_index, :preview_image, :content)
    end
end
