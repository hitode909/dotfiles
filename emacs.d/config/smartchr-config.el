;; smartchr
(require 'smartchr)
(global-set-key (kbd "=") (smartchr '(" = " "=" " == " "=")))
(global-set-key (kbd "G") (smartchr '("G" "ありがとうございます")))
;; (global-set-key (kbd "!") (smartchr '("!" "!!" " != ")))
;; (global-set-key (kbd "<") (smartchr '("<" "<<" " < " " <= ")))
;; (global-set-key (kbd "{") (smartchr '("{ `!!' }" "{")))
(add-hook 'cperl-mode-hook
          '(lambda ()
             (define-key cperl-mode-map (kbd ">") (smartchr '(">" " => " ">>" " > " " >= " " => '`!!''" " => \"`!!'\"")))
             (define-key cperl-mode-map (kbd "F") (smartchr '("F" "$" "$_" "$_->" "@$")))
             (define-key cperl-mode-map (kbd "M") (smartchr '("M" "my $`!!' = ")))
             (define-key cperl-mode-map (kbd "D") (smartchr '("D" "use Data::Dumper; warn Dumper `!!';")))
             (define-key cperl-mode-map (kbd "S") (smartchr '("S" "my ($self) = @_;" "my ($self, $`!!') = @_;")))
             (define-key cperl-mode-map (kbd "C") (smartchr '("C" "my ($class) = @_;" "my ($class, $`!!') = @_;")))
             (define-key cperl-mode-map (kbd ".") (smartchr '("->" "." "..")))
             (define-key cperl-mode-map (kbd "|") (smartchr '(" || " "|")))
             (define-key cperl-mode-map (kbd "&") (smartchr '(" && " "&")))
             (define-key cperl-mode-map (kbd "{") (smartchr '("{" "sub { `!!' ")))

             ))

;; (define-key espresso-mode-map (kbd "L") (smartchr '("L" "console.log(`!!');")))
(add-hook 'ruby-mode-hook
          '(lambda ()
             (define-key ruby-mode-map (kbd "P") (smartchr '("P" "require pp; pp ")))
             (define-key ruby-mode-map (kbd ">") (smartchr '(">" " => " ">>" " > " " >= " " => '`!!''" " => \"`!!'\"")))
             ))

(add-hook 'espresso-mode-hook
          '(lambda ()
             (define-key espresso-mode-map (kbd "F") (smartchr '("F" "function() { `!!' }")))
             ))
