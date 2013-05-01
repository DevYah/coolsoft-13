class StreamController < ApplicationController
	
  #This is the action that controls the stream through having 4 aparameters manipulated in a way that they change the 
  #value of the @ideas that is sent
  #+params+:mypage,search,tag,search_user
  #Mohamed Salah Nazir
  @@filter_all = []

  def index
    @page = params[:mypage]
    @searchtext = params[:search]
    @search_with_user = params[:search_user] == "true"
    @searching_with = params[:searchtype] == "true"
    @insert = params[:insert]
    
    if params[:reset_global]
      @@filter_all = []
    end

    if params[:set_global]
      @@filter_all = params[:tag].to_a
      @filter_tmp = @@filter_all      
    else
      @filter_tmp = @@filter_all+params[:tag].to_a
    end

    if @page.nil?
      if @searchtext.nil?  
        @ideas = Idea.order(:created_at).page(params[:mypage]).per(10)
      else
        if !@searching_with
          @ideas = Idea.search(params[:search]).order(:created_at).page(params[:mypage]).per(10)
        else
          @users = User.search(params[:search]).page(params[:mypage]).per(10)
        end
      end
    else
      if @searchtext != "" and @filter_tmp == []
        if @search_with_user
          @users = User.search(params[:search]).page(params[:mypage]).per(10)
        else  
          @ideas = Idea.search(params[:search]).order(:created_at).page(params[:mypage]).per(10)
        end
      else
        if @searchtext == "" and @filter_tmp != []
          @ideas = Idea.filter(@filter_tmp).sort{|i1,i2| i1.created_at <=> i2.created_at}.uniq
          @ideas = Kaminari.paginate_array(@ideas).page(params[:mypage]).per(10)
          @filter_tmp.uniq
        else
          if @search_with_user
            @users = User.search(params[:search]).page(params[:mypage]).per(10)
          else
            @ideas = Idea.order(:created_at).page(params[:mypage]).per(10)
          end
        end
      end
    end
  end
end

#   def index

#     @page = params[:mypage].to_i
#     @searchtext = params[:search]
#     @filter = params[:tag].to_a
#     @search_with_user = params[:search_user] == "true"
#     @searching_with = params[:searchtype] == "true"
#     @insert = params[:insert]
#     @filter_this = []
    

#     if @insert != nil
#       if @insert == "true"
#         @filter_tmp = @@filter_all
#         if @filter_tmp.empty?
#           @approve_insert = true
#         else
#         @filter_tmp.each do|tag|
#           if [tag] == @filter
#             @approve_insert = false
#           end
#         end
#       end
#         if @approve_insert != false
#           @@filter_all = @@filter_all+@filter
#           @filter_this = @@filter_all
#         else
#           @filter_this = @@filter_all
#         end
#       else
#         if @filter.empty?
#         @@filter_all = []
#         @filter_this = []
#         else
#         @@filter_all = @@filter_all-@filter
#         @filter_this = @@filter_all
#       end
#       end
#     end

#     if @searchtext.to_s.strip.length > 0
#       @@filter_all = []
#       @filter_this = []
#     end

#   if @page != nil
#     if !@search_with_user
#       if @searchtext.to_s.strip.length == 0 and @filter_this.empty?
#         @ideas = Idea.order(:created_at).page(params[:mypage]).per(10)
#         @@filter_all = []
#         @filter_this = []
#         respond_to do |format|
#           format.html
#           format.js
#         end
#       else
#         if @searchtext.to_s.strip.length > 0 and @filter_this.empty?
#           @ideas = Idea.search(params[:search]).order(:created_at).page(params[:mypage]).per(10)
#           @@filter_all = []
#           @filter_this = []
#         else
#           @ideas = Idea.filter(@filter_this).sort{|i1,i2| i1.created_at <=> i2.created_at}.uniq
#           @ideas = Kaminari.paginate_array(@ideas).page(params[:mypage]).per(10)
#         end
#       end
#     else
#       @users = User.search(params[:search]).page(params[:mypage]).per(10)
#       @@filter_all = []
#       @filter_this = []
#     end
#   else
#     if @searchtext.nil?
#       @ideas = Idea.order(:created_at).page(params[:mypage]).per(10)
#       @@filter_all = []
#       @filter_this = []
#     else
#       if !@searching_with
#         @ideas = Idea.search(params[:search]).order(:created_at).page(params[:mypage]).per(10)
#         @@filter_all = []
#         @filter_this = []
#       else
#         @users = User.search(params[:search]).page(params[:mypage]).per(10)
#         @@filter_all = []
#         @filter_this = []
#       end
#     end
# 	end
# end