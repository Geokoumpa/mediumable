module Mediumable
  module ActiveRecordExtensions
    module ClassMethods
      def acts_as_mediumable
        make_it_mediumable! unless included_modules.include?(InstanceMethods)
      end

      private

      def make_it_mediumable!
        include InstanceMethods
        before_save :position_media
        has_many :media, :as => :mediumable, :order => :position
        has_many :images, :class_name => "Medium", :as => :mediumable, :order => :position, :conditions => "data_content_type LIKE '%image%'"
        has_many :files, :class_name => "Medium", :as => :mediumable, :order => :position, :conditions => "data_content_type NOT LIKE '%image%'"
      end
    end

    module InstanceMethods
      
      def position_media
        self.media.each_with_index do |m, i|
          m.update_attributes :position => i+1
        end
      end

      def thumb
        (@model_images ||= images).first
      end

      def has_thumb?
        !thumb.nil?
      end

      def concatenated_media_ids=(ids)
        ids = ids.split(",").compact.reject(&:blank?)
        self.media.each do |medium|
          medium.mark_for_destruction unless ids.include?(medium.id.to_s)
        end
        ms = Medium.find_all_by_id(ids)
        ms.each{ |m| m.update_attribute(:position, (ids.index(m.id.to_s) + 1)) }
        self.media = ms
      end

      def concatenated_media_ids
        self.media.map(&:id).join(',')
      end
    end
  end
end

ActiveRecord::Base.extend Mediumable::ActiveRecordExtensions::ClassMethods
