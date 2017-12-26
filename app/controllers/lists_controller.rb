class ListsController < ApplicationController
  before_action :set_list, :only => [:show, :edit, :update, :destroy, :is_done]

  def index
    # 依到期日 (due_date) 近到遠，取得 todos
    @lists = List.order(duedate: :asc)
    # @lists = List.all
  end

  def new
    @list = List.new
  end

  def create
    # 依傳入參數 new 一個 List 實例
    @list = List.new(list_params)
    # 如果驗證成功，則儲存，並回到列表頁，告知成功新增
    # 如果驗證失敗，則不儲存，並保留已填寫資訊，回到 new，繼續填寫
    if @list.save
      # 跳出通知訊息，告知成功新增
      flash[:success] = 'List was successfully created !!'
      # 重新發出 request，導往列表頁。對瀏覽器來說會重整頁面
      redirect_to lists_url
    else
      # 當驗證失敗時，將 @todo 傳入 new.html.erb 做 render
      # 以達成體驗上：「保留已填寫資料，讓使用者可以繼續填寫錯誤的部分」
      render :action => :new
    end
  end

  # 彷彿沒有內容，是因為原先此 action 內的代碼:
  # @list = List.find(params[:id])
  # 此行的作用已被 before_action :set_list 取代
  def show
  end

  # 彷彿沒有內容，是因為原先此 action 內的代碼:
  # @list = List.find(params[:id])
  # 此行的作用已被 before_action :set_list 取代
  def edit
  end

  def update
    # @list = List.find(params[:id])
    # 此行的作用已被 before_action :set_list 取代
    if @list.update_attributes(list_params)
      # 跳出通知訊息，告知成功更新
      flash[:success] = 'List Was Successfully Updated !!'
      # 重新發出 request，導往列表頁。對瀏覽器來說會重整頁面
      redirect_to list_path(@list)
    else
      # 當驗證失敗時，將 @list 傳入 edit.html.erb 做 render
      # 以達成體驗上：「保留已填寫資料，讓使用者可以繼續填寫錯誤的部分」
      render :action => :edit
    end
  end

  def destroy
    if @list.duedate >= Time.now.to_date
      @list.destroy
      flash[:info] = "已刪除!" 
    else
      flash[:danger] = "超過期限，無法刪除!" 
    end
    redirect_to lists_url
  end

  def is_done
    @list.update(is_done: !(@list.is_done))
  end
  
  #######################################################
  #
  # 以下為 private 區塊
  #
  #
  private

  # 在 #show, #edit, #update, #destroy 都有找到特定 ID list 的需求
  # 於是可以提取出 before_action :set_list
  # 在以上三個 actions 執行之前，先找出特定 ID 的 list
  def set_list
    @list = List.find(params[:id])
  end

  def list_params
    # params 變數是 Rails 在消化完 http request 後，所留下的 controller 常用參數群
    # #require 方法裡的 symbol 與 form 送回的物件名稱相同
    # #permit  方法裡的 symbol 與 form 送回的物件欄位名稱相同
    params.require(:list).permit(:event, :duedate, :description)
  end
end
