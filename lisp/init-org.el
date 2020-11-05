;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Filename: init-org.el
;; Description: 
;; Author: Mateo Rodriguez Ripolles (teorodrip@posteo.net)
;; Maintainer: 
;; Created: Tue Oct  6 09:50:41 2020 (+0200)
;; Last-Updated: Thu Nov  5 18:19:33 2020 (+0100)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Function to determine work time
(defun calcFunc-dateDiffToHMS (date1 date2 worktime-per-day)
  "Calculate the difference of DATE1 and DATE2 in HMS form.
Each day counts with WORKTIME-PER-DAY hours."
  (cl-labels ((dateTrunc (date)
                         (calcFunc-date (calcFunc-year date)
                                        (calcFunc-month date)
                                        (calcFunc-day date)))
              (datep (date)
                     (and (listp date)
                          (eq (car date) 'date))))
    (if (and (datep date1)
             (datep date2))
        (let* ((business-days (calcFunc-bsub
                               (dateTrunc date1)
                               (dateTrunc date2))))
          (calcFunc-add
           (calcFunc-hms (calcFunc-mul business-days worktime-per-day) 0 0)
           (calcFunc-sub (calcFunc-time date1) (calcFunc-time date2)))
          )
      0)))

(defun insert-week-hours-table ()
  "Insert week table for the hours."
  (interactive)
  (end-of-buffer)
  (let* ((now (decode-time))
         (this-week (copy-sequence now))
         (next-week (copy-sequence now)))
    (cl-decf (nth 3 this-week) (mod (- (nth 6 this-week) 1) 7))
    (cl-incf (nth 3 next-week) (mod (- 7 (nth 6 next-week)) 7))
    (insert (format-time-string "* %G: Week => %B(%d) - " (apply #'encode-time this-week))
            (format-time-string "%B(%d)\n" (apply #'encode-time next-week))
            "   |   | ENTRADA | SALIDA | HORAS |\n"
            "   |---+---------+--------+-------|\n"
            "   | # |         |        |       |\n"
            "   | # |         |        |       |\n"
            "   | # |         |        |       |\n"
            "   | # |         |        |       |\n"
            "   | # |         |        |       |\n"
            "   |---+---------+--------+-------|\n"
            "   |   |         |        |       |\n"
            "   #+TBLFM: $4=dateDiffToHMS($3,$2,8)::@>$>=vsum(@I$>..@II$>)\n")))

;; Show whole lines in buffer
(add-hook 'org-mode-hook #'visual-line-mode)

(provide 'init-org)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-org.el ends here
