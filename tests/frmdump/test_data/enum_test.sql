CREATE TABLE `enum_test` (
  `a` enum('a','b','c') DEFAULT 'b',
  `b` enum('q','r','s') NOT NULL,
  `c` enum('a:b','a:c','a:d','a:e','a:f','a:g','a:h','a:i','a:j','a:k','a:l','a:m','a:n','a:o','a:p','a:q','a:r','a:s','a:t','a:u','a:v','a:w','a:x','a:y','a:z','a:A','a:B','a:C','a:D','a:E','a:F','a:G','a:H','a:I','a:J','a:K','a:L','a:M','a:N','a:O','a:P','a:Q','a:R','a:S','a:T','a:U','a:V','a:W','a:X','a:Y','a:Z','b:a','b:c','b:d','b:e','b:f','b:g','b:h','b:i','b:j','b:k','b:l','b:m','b:n','b:o','b:p','b:q','b:r','b:s','b:t','b:u','b:v','b:w','b:x','b:y','b:z','b:A','b:B','b:C','b:D','b:E','b:F','b:G','b:H','b:I','b:J','b:K','b:L','b:M','b:N','b:O','b:P','b:Q','b:R','b:S','b:T','b:U','b:V','b:W','b:X','b:Y','b:Z','c:a','c:b','c:d','c:e','c:f','c:g','c:h','c:i','c:j','c:k','c:l','c:m','c:n','c:o','c:p','c:q','c:r','c:s','c:t','c:u','c:v','c:w','c:x','c:y','c:z','c:A','c:B','c:C','c:D','c:E','c:F','c:G','c:H','c:I','c:J','c:K','c:L','c:M','c:N','c:O','c:P','c:Q','c:R','c:S','c:T','c:U','c:V','c:W','c:X','c:Y','c:Z','d:a','d:b','d:c','d:e','d:f','d:g','d:h','d:i','d:j','d:k','d:l','d:m','d:n','d:o','d:p','d:q','d:r','d:s','d:t','d:u','d:v','d:w','d:x','d:y','d:z','d:A','d:B','d:C','d:D','d:E','d:F','d:G','d:H','d:I','d:J','d:K','d:L','d:M','d:N','d:O','d:P','d:Q','d:R','d:S','d:T','d:U','d:V','d:W','d:X','d:Y','d:Z','e:a','e:b','e:c','e:d','e:f','e:g','e:h','e:i','e:j','e:k','e:l','e:m','e:n','e:o','e:p','e:q','e:r','e:s','e:t','e:u','e:v','e:w','e:x','e:y','e:z','e:A','e:B','e:C','e:D','e:E','e:F','e:G','e:H','e:I','e:J','e:K','e:L','e:M','e:N','e:O','e:P','e:Q','e:R','e:S','e:T','e:U','e:V','e:W','e:X','e:Y','e:Z','f:a') DEFAULT 'c:x'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
