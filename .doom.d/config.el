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
   org-todo-keywords '((sequence "TODO(t)" "PROGRESS(p)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)"))
   org-todo-keyword-faces
   '(("TODO" :foreground "#7c7c75" :weight normal :underline t)
     ("WAITING" :foreground "#9f7efe" :weight normal :underline t)
     ("PROGRESS" :foreground "#0098dd" :weight normal :underline t)
     ("DONE" :foreground "#50a14f" :weight normal :underline t)
     ("CANCELLED" :foreground "#ff6480" :weight normal :underline t))
   org-priority-faces '((65 :foreground "#e45649")
                        (66 :foreground "#da8548")
                        (67 :foreground "#0098dd"))
   ))
