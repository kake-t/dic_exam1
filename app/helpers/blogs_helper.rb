module BlogsHelper
    def choose_new_or_edit
        if action_name == 'new'|| action_name == 'confirm'
           confirm_blogs_path
        else action_name == 'edit'
           blog_path
        end
    end
end
