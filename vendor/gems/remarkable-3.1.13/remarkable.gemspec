# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{remarkable}
  s.version = "3.1.13"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Carlos Brando", "Jos\303\251 Valim"]
  s.date = %q{2010-02-19}
  s.description = %q{Remarkable: a framework for rspec matchers, with support to macros and I18n.}
  s.email = ["eduardobrando@gmail.com", "jose.valim@gmail.com"]
  s.extra_rdoc_files = ["README", "LICENSE", "CHANGELOG"]
  s.files = ["README", "LICENSE", "CHANGELOG", "lib/remarkable", "lib/remarkable/base.rb", "lib/remarkable/core_ext", "lib/remarkable/core_ext/array.rb", "lib/remarkable/dsl", "lib/remarkable/dsl/assertions.rb", "lib/remarkable/dsl/callbacks.rb", "lib/remarkable/dsl/optionals.rb", "lib/remarkable/dsl.rb", "lib/remarkable/i18n.rb", "lib/remarkable/macros.rb", "lib/remarkable/matchers.rb", "lib/remarkable/messages.rb", "lib/remarkable/negative.rb", "lib/remarkable/pending.rb", "lib/remarkable/rspec.rb", "lib/remarkable/version.rb", "lib/remarkable.rb", "locale/en.yml", "remarkable.gemspec"]
  s.homepage = %q{http://github.com/carlosbrando/remarkable}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{remarkable}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Remarkable: a framework for rspec matchers, with support to macros and I18n.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rspec>, [">= 1.2.0"])
    else
      s.add_dependency(%q<rspec>, [">= 1.2.0"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 1.2.0"])
  end
end
