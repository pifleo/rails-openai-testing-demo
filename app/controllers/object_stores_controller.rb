class ObjectStoresController < ApplicationController
  before_action :set_object_store, only: %i[ show edit update destroy ]

  # GET /object_stores or /object_stores.json
  def index
    @object_stores = ObjectStore.all
  end

  # GET /object_stores/1 or /object_stores/1.json
  def show
  end

  # GET /object_stores/new
  def new
    @object_store = ObjectStore.new
  end

  # GET /object_stores/1/edit
  def edit
  end

  # POST /object_stores or /object_stores.json
  def create
    @object_store = ObjectStore.new(object_store_params)

    respond_to do |format|
      if @object_store.save
        format.html { redirect_to object_store_url(@object_store), notice: "Object store was successfully created." }
        format.json { render :show, status: :created, location: @object_store }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @object_store.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /object_stores/1 or /object_stores/1.json
  def update
    respond_to do |format|
      if @object_store.update(object_store_params)
        format.html { redirect_to object_store_url(@object_store), notice: "Object store was successfully updated." }
        format.json { render :show, status: :ok, location: @object_store }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @object_store.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /object_stores/1 or /object_stores/1.json
  def destroy
    @object_store.destroy!

    respond_to do |format|
      format.html { redirect_to object_stores_url, notice: "Object store was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def remove_document
    @document = ActiveStorage::Attachment.find(params[:id])
    @document.purge_later
    redirect_back(fallback_location: request.referer)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_object_store
      @object_store = ObjectStore.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def object_store_params
      params.require(:object_store).permit(:name, :content, documents: [])
    end
end
