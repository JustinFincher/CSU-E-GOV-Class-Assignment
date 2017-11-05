include UsersHelper

class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :edit, :update, :destroy]

  # GET /documents
  # GET /documents.json
  def index
    if !logged_in?
      redirect_to login_path, notice: '您需要登陆'
    else
      @documents = Document.select { |doc| doc.user_id == current_user.id}
    end
  end

  def index_hand_over
    if !logged_in?
      redirect_to login_path, notice: '您需要登陆'
    else
      @documents = Document.select { |doc| current_user.to_review_documents.include?(doc.id.to_s) }
    end
  end

  def index_reviewed
    if !logged_in?
      redirect_to login_path, notice: '您需要登陆'
    else
      @documents = Document.select { |doc| current_user.reviewed_documents.include?(doc.id.to_s) }
    end
  end

  # GET /documents/1
  # GET /documents/1.json
  def show
    if !logged_in?
      redirect_to login_path, notice: '您需要登陆'
    else
      doc_id = params[:document_id]
      # logger.debug 'doc_id'
      # logger.debug doc_id
      if doc_id != nil
        @document = Document.find doc_id
      end
    end
  end

  # GET /documents/new
  def new
    if !logged_in?
      redirect_to login_path, notice: '您需要登陆'
    else
      @document = Document.new
    end
  end

  # GET /documents/1/edit
  def edit
    if !logged_in?
      redirect_to login_path, notice: '您需要登陆'
    else
      if !is_admin_or_upper?
        if @document.user_id != current_user.id
          redirect_to user_documents_path, notice: '您无权编辑他人公文'
        end
      end
    end
  end

  # POST /documents
  # POST /documents.json
  def create
    @document = Document.new(document_params)
    if @document.user_id == nil
      @document.user_id = current_user.id
    end
    respond_to do |format|
      if @document.save
        format.html { redirect_to user_documents_path, notice: 'Document was successfully created.' }
        format.json { render :show, status: :created, location: @document }
      else
        format.html { render :new }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /documents/1
  # PATCH/PUT /documents/1.json
  def update

    logger.info params[:tags]


    respond_to do |format|
      if @document.update(document_params)
        format.html { redirect_to user_documents_path, notice: 'Document was successfully updated.' }
        format.json { render :show, status: :ok, location: @document }
      else
        format.html { render :edit }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document.destroy
    respond_to do |format|
      format.html { redirect_to user_documents_path, notice: '公文被删除' }
      format.json { head :no_content }
    end
  end

  def hand_over_to_upper
    if !logged_in?
      redirect_to login_path, notice: '您需要登陆'
    else
      doc_id = params[:document_id]
      if doc_id != nil
        @document = Document.find doc_id
      end
    end

    hand_over_to_person_id = params[:hand_over_to_person_id]
    hand_over_person = User.find hand_over_to_person_id
    hand_over_person.to_review_documents.push(@document.id.to_s)
    hand_over_person.to_review_documents = hand_over_person.to_review_documents.uniq
    if hand_over_person.save
    end

    respond_to do | format |
      format.html { redirect_to user_document_path(:id => @document.id), notice: '公文已经发往 '<<hand_over_person.name.to_s }
      format.json { render :show, status: :ok, location: @document }
    end

  end

  def submit_review_by_upper
    if !logged_in?
      redirect_to login_path, notice: '您需要登陆'
    else
      doc_id = params[:document_id]
      if doc_id != nil
        @document = Document.find doc_id
      end
    end

    doc_review = params[:review_content]
    doc_opinion = params[:review_opinion]

    review = Review.new
    review.user_id = current_user.id
    review.document_id = @document.id
    review.content = doc_review
    review.save

    logger.info doc_review
    logger.info doc_opinion
    logger.info review

    @document.review_state = doc_opinion
    @document.reviews.push(review.id)

    is_save_success = @document.save
    if is_save_success
      # remove doc in user_to_review
      current_user.to_review_documents.delete(@document.id.to_s)
      current_user.reviewed_documents.push(@document.id.to_s)
      is_save_success = current_user.save
    end

    respond_to do | format |
      if is_save_success
        format.html { redirect_to user_documents_index_hand_over_path, notice: '公文已经审批' }
        format.json { render :show, status: :ok, location: @document }
      else
        format.html { render :new }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_document
    @document = Document.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def document_params
    params.require(:document).permit(:tite, :content, {:tags => []})
  end
end
