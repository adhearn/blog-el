(defvar blog-base-directory "/Users/adhearn/workspace/adhearn.github.io/_posts"
  "The directory that holds blog posts.")

(defvar blog-date-format-string "%Y-%m-%d"
  "Format string for Jekyll header.")

(defun blog-filename-for-time
    (time post-name)
  "Return the filename corresponding to the given TIME and POST-NAME'."
  (let ((date-str (format-time-string blog-date-format-string time)))
    (convert-standard-filename
     (format "%s/_%s-%s.md" blog-base-directory date-str post-name))))

(defun blog-insert-header
    (time)
  "Insert an appropriate Jekyll header with date TIME."
  (let ((formatted-date (format-time-string blog-date-format-string time)))
    (insert (format "---\nlayout: post\ntitle: \ndate: %s\ncategories: \n---" formatted-date))
    (insert "\n")))

(defun blog-make-post
    (post-name)
  "Create a properly jekyll-formatted filename for POST-NAME."
  (let* ((time (current-time))
         (filename (blog-filename-for-time time post-name))
         (buffer (find-file filename)))
    (when (= (buffer-size buffer) 0)
      (blog-insert-header time))
    (visual-line-mode)))

(defun blog-new-post (post-filename)
  "Call blog-make-post interactively, using the filename provided by POST-FILENAME."
  (interactive "sPost Filename: ")
  (blog-make-post post-filename))

(provide 'blog)
;;; blog.el ends here
