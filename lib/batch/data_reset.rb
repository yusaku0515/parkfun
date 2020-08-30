class Batch::DataReset
  def self.weekly_data_reset
    # 週間の投稿数、会員登録数をリセット
	@posts_week = 0
	@users_week = 0
    p "カウントをリセットしました"
  end

  def self.monthly_data_reset
    # 月間の投稿数、会員投稿数をリセット
	@posts_month = 0
	@posts_month = 0
    p "カウントをリセットしました"
  end
end