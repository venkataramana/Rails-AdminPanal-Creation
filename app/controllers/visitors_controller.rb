        class VisitorsController < ApplicationController
          # Be sure to include AuthenticationSystem in Application Controller instead
          before_filter :loggedin, :only => [:index, :show, :edit, :update, :destroy]
          include AuthenticatedSystem
           def index

                         if !params[:per_page].nil? && !params[:per_page].blank?
                                 if params[:per_page] != "all"
                                        @limit= params[:per_page].to_i
                                end
                        else
                                @limit = 6
                        end

                         if !params[:sort].nil?
                              sort = params[:sort]
                        else
                                sort = "id"
                        end

                        if !params[:sorten].nil?
                                sorten = params[:sorten]
                                if params[:sorten] == "Asc"
                                        @sorten_list = "Desc"
                                else
                                        @sorten_list = "Asc"
                                end
                        else
                                sorten = "Asc"
                                @sorten_list = "Desc"
                        end

                        if !params[:option].nil? && !params[:option].blank?
                                @option= params[:option].to_s
                        else
                                @option="name"
                        end

                                @visitors = Visitor.paginate :page => params[:page], :per_page => @limit, :conditions => ["#{@option} LIKE ?","#{params[:search]}%"], :order=>"visitors.#{sort} #{sorten}"

                end

          # render new.rhtml
          def new
            @visitor = Visitor.new
          end

          def create
            #logout_keeping_session!
            @visitor = Visitor.new(params[:visitor])
            success = @visitor && @visitor.save
            if success && @visitor.errors.empty?
                    # Protects against session fixation attacks, causes request forgery
              # protection if visitor resubmits an earlier form using back
              # button. Uncomment if you understand the tradeoffs.
              # reset session
              self.current_visitor = @visitor # !! now logged in
              redirect_to "/visitors"
              flash[:notice] = "Thanks for signing up!  We're sending you an email with your activation code."
            else
              flash[:error]  = "We couldn't set up that account, sorry.  Please try again."
              render :action => 'new'
            end
          end
          def edit
                @visitor=Visitor.find(params[:id])
          end
          def update
                @visitor=Visitor.find(params[:id])
                @visitor.update_attributes(params[:visitor])
                redirect_to "/visitors"
                flash[:notice] = "Your sign up page was updated successfully"
        end

          def destroy
                       @visitor=Visitor.find(params[:id])
                        @visitor.destroy
                        flash[:notice]="1 visitor deleted success fully"
                        redirect_to "/visitors"
                end
           def list_action
	        id_string = params[:chk].join(',') if !params[:chk].nil?
	        condition_string = " id in (#{id_string})";
	        effectedRows = params[:chk].length if !params[:chk].nil?;
	        case  params[:make_action]
                        when  "active"
                                flash[:notice]="No activation"
                                redirect_to :controller=>'visitors'
                        when  "inactive"
                                flash[:notice]="No deactivation"
                                redirect_to :controller=>'visitors'
                        when  "all"
                                flash[:notice]="Original Page"
                                redirect_to :controller=>'visitors'
		        when    "delete"
			        Visitor.delete_all(condition_string)
			        flash[:notice]="#{effectedRows} visitor(s) deleted successfully."
			        redirect_to :controller=>'visitors'
	        end

        end
                def loggedin
                        redirect_to "/sessions" if session[:visitor_id].nil?
                end
        end

