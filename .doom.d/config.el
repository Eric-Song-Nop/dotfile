;; (defun my-org-screenshot ()
;;   "Take a screenshot into a time stamped unique-named file in the
;; same directory as the org-buffer and insert a link to this file."
;;   (interactive)
;;   (setq filename
;;         (concat
;;          (make-temp-name
;;           (concat (buffer-file-name)
;;                   "_"
;;                   (format-time-string "%Y%m%d_%H%M%S_")) ) ".png"))
;;   (call-process "import" nil nil nil filename)
;;   (insert (concat "[[" filename "]]"))
;;   (org-display-inline-images))

(after! org
  (setq
   org-bullets-bullet-list '("⁖")
   org-ellipsis " ... "
   ))

(setq display-line-numbers-type 'relative)
(setq doom-font (font-spec :family "CaskaydiaCove Nerd Font Mono" :size 29))
(setq org-log-done 'time)
