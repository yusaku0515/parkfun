class Admins::HomesController < ApplicationController
	def top
		@users = User.count #累計
		@users_week = User.where("created_at >= ?", Time.zone.now.beginning_of_week).count #週間での集計 WEEKだと他の年と一緒になる→YEARWEEKにする
		@users_month = User.where("created_at >= ?", Time.zone.now.beginning_of_month).count #月間での集計
		@posts = Post.count
		@posts_week = Post.where("created_at >= ?", Time.zone.now.beginning_of_week).count
		@posts_month = Post.where("created_at >= ?", Time.zone.now.beginning_of_month).count
	end
end
