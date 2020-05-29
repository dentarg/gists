# rack, rack-test and Content-Length business

with rack 1.6.12

    BUNDLE_GEMFILE=Gemfile_rack-1.6 bundle e rspec

<!-- -->

    {"Content-Type"=>"text/html;charset=utf-8", "Content-Length"=>"4", "X-XSS-Protection"=>"1; mode=block", "X-Content-Type-Options"=>"nosniff", "X-Frame-Options"=>"SAMEORIGIN"}

with rack 2.2.2

    BUNDLE_GEMFILE=Gemfile_rack-2.2 bundle e rspec

<!-- -->

    {"Content-Type"=>"text/html;charset=utf-8", "Content-Length"=>"4", "X-XSS-Protection"=>"1; mode=block", "X-Content-Type-Options"=>"nosniff", "X-Frame-Options"=>"SAMEORIGIN"}
