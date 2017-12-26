# == Schema Information
#
# Table name: lists
#
#  id。       :integer          not null, primary key
#  event      :string           not null
#  duedate    :date             not null
#  description       :text
#

# :nodoc:
class List < ApplicationRecord
  # 驗證：欄位必須有值
  # 預設不允許空白字元，可用 allow_blank: :true 開啟允許空白
  validates_presence_of :event, :duedate
  # 驗證：長度 20 個字符
  # 英文是 20 個字母，中文則是 20 個字
  validates :event, length: { maximum: 20 }

end
