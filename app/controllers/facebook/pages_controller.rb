class Facebook::PagesController < ApplicationController
  before_action :set_facebook_page, only: [:show, :edit, :update, :destroy]

  # GET /facebook/pages
  # GET /facebook/pages.json
  def index
    @facebook_pages = Facebook::Page.all
  end

  # GET /facebook/pages/1
  # GET /facebook/pages/1.json
  def show
  end

  # GET /facebook/pages/new
  def new
    @facebook_page = Facebook::Page.new
  end

  # GET /facebook/pages/1/edit
  def edit
  end

  # POST /facebook/pages
  # POST /facebook/pages.json
  def create
    @facebook_page = Facebook::Page.new(facebook_page_params)

    respond_to do |format|
      if @facebook_page.save
        format.html { redirect_to @facebook_page, notice: 'Page was successfully created.' }
        format.json { render action: 'show', status: :created, location: @facebook_page }
      else
        format.html { render action: 'new' }
        format.json { render json: @facebook_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /facebook/pages/1
  # PATCH/PUT /facebook/pages/1.json
  def update
    respond_to do |format|
      if @facebook_page.update(facebook_page_params)
        format.html { redirect_to @facebook_page, notice: 'Page was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @facebook_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /facebook/pages/1
  # DELETE /facebook/pages/1.json
  def destroy
    @facebook_page.destroy
    respond_to do |format|
      format.html { redirect_to facebook_pages_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_facebook_page
      @facebook_page = Facebook::Page.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def facebook_page_params
      params.require(:facebook_page).permit(:url, :name)
    end

    def scheduled_page_like_check_params
      params.permit(scheduled_page_like_check: [:via, :attempts, :wait_between_requests])
    end

    def scheduled_page_like_check
      @scheduled_page_like_check ||= @facebook_page.scheduled_page_like_checks.new(scheduled_page_like_check_params)
    end

    helper_method :scheduled_page_like_check
end
