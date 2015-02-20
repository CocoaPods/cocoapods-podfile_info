module Pod
  class Command
    class PodfileInfo < Command

      self.summary = 'Shows information on installed Pods.'
      self.description = <<-DESC
        Shows information on installed Pods in current Project.
        If optional `PODFILE_PATH` provided, the info will be shown for
        that specific Podfile
      DESC
      self.arguments = [
        CLAide::Argument.new('PODFILE_PATH', false)
      ]

      def self.options
        [
            ["--all", "Show information about all Pods with dependencies that are used in a project"],
            ["--md", "Output information in Markdown format"],
            ["--csv", "Output information in Markdown format"]
        ].concat(super)
      end

      def initialize(argv)
        @info_all = argv.flag?('all')
        
        @type = :text
        @type = :md if argv.flag?('md')
        @type = :csv if argv.flag?('csv')

        @podfile_path = argv.shift_argument
        super
      end

      def run
        use_podfile = (@podfile_path || !config.lockfile)

        if !use_podfile
          UI.puts "Using lockfile" if config.verbose?
          verify_lockfile_exists!
          lockfile = config.lockfile
          pods = lockfile.pod_names
          if @info_all
            deps = lockfile.dependencies.map{|d| d.name}
            pods = (deps + pods).uniq
          end
        elsif @podfile_path
          podfile = Pod::Podfile.from_file(@podfile_path)
          pods = pods_from_podfile(podfile)
        else
          verify_podfile_exists!
          podfile = config.podfile
          pods = pods_from_podfile(podfile)
        end

        UI.puts "\nPods used:\n".yellow unless @info_in_md
        pods_info(pods, @type)
      end

      def pods_from_podfile(podfile)
        pods = []
        podfile.root_target_definitions.each {|e| h = e.to_hash; pods << h['dependencies'] if h['dependencies']}
        pods.flatten!
        pods.collect! {|pod| (pod.is_a?(Hash)) ? pod.keys.first : pod}
      end

      def pods_info_hash(pods, keys=[:name, :version, :homepage, :summary, :license])
        pods_info = []
        pods.each do |pod|
          spec = (Pod::SourcesManager.search_by_name(pod).first rescue nil)
          if spec
            info = {}
            keys.each { |k| info[k] = spec.specification.send(k) }
            pods_info << info
          end
        end
        pods_info
      end

      def pods_info(pods, type)
        pods = pods_info_hash(pods, [:name, :version, :homepage, :summary, :license])
        UI.puts "name,version,homepage,summary,license" if type == :csv

        pods.each do |pod|
          case type
          when :md
            UI.puts "* [#{pod[:name]} - #{pod[:version]}](#{pod[:homepage]}) [#{pod[:license][:type]}] - #{pod[:summary]}"
          when :csv
            UI.puts "#{pod[:name]},#{pod[:version]},#{pod[:homepage]},\"#{pod[:summary]}\",\"#{pod[:license][:type]}\""
          else
            UI.puts "- #{pod[:name]} (#{pod[:version]}) [#{pod[:license][:type]}]".green
            UI.puts "  #{pod[:summary]}\n\n"
          end
        end
      end
    end
  end
end

