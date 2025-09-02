; extends

;; Highlight self artifactId and version in Maven's pom.xml
(document
  root: (element
    (STag (Name) @root_tag (#eq? @root_tag "project"))
    (content (element
      (STag (Name) @yellow.bold (#any-of? @yellow.bold "artifactId" "version"))
      (content)    @text.bold
      (ETag (Name) @yellow.bold)))))
