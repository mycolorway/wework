module Wework
  module Api
    module Methods
      module Tag
        def tag_create(tagname, tagid=nil)
          data = {tagname: tagname}
          data[:tagid] = tagid unless tagid.nil?
          post 'tag/create', data
        end

        def tag_update(tagid, tagname)
          post 'tag/update', {tagid: tagid, tagname: tagname}
        end

        def tag_delete tagid
          get 'user/delete', params: {tagid: tagid}
        end

        def tag_get tagid
          get 'user/get', params: {tagid: tagid}
        end

        def tag_addtagusers tagid, userlist=[], partylist=[]
          post 'tag/addtagusers', {tagid: tagid, userlist: userlist, partylist: partylist}
        end

        def tag_deltagusers tagid, userlist=[], partylist=[]
          post 'tag/deltagusers', {tagid: tagid, userlist: userlist, partylist: partylist}
        end

        def tag_list
          get 'user/list'
        end
      end
    end
  end
end