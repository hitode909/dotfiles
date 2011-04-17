;; smartchr
(require 'smartchr)
(global-set-key (kbd "=") (smartchr '(" = " "=" " == " "=")))
(global-set-key (kbd "J") (smartchr '("J" "->" "J")))
; (global-set-key (kbd "!") (smartchr '("!" "!!" " != ")))
(global-set-key (kbd "<") (smartchr '("<" "<<" " < " " <= ")))
(global-set-key (kbd "{") (smartchr '("{ `!!' }" "{")))
(global-set-key (kbd ">") (smartchr '(">" " => " ">>" " > " " >= " " => '`!!''" " => \"`!!'\"")))
(global-set-key (kbd "F") (smartchr '("F" "$" "$_" "$_->" "@$")))
(define-key cperl-mode-map (kbd "M") (smartchr '("M" "my $`!!' = ")))
(define-key cperl-mode-map (kbd "D") (smartchr '("D" "use Data::Dumper; warn Dumper `!!';")))
(define-key cperl-mode-map (kbd "S") (smartchr '("S" "my ($self) = @_;" "my ($self, $`!!') = @_;")))

;; (define-key espresso-mode-map (kbd "L") (smartchr '("L" "console.log(`!!');")))
(add-hook 'ruby-mode-hook
          '(lambda ()
             (define-key ruby-mode-map (kbd "P") (smartchr '("P" "require pp; pp ")))
             ))
