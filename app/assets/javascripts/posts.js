document.addEventListener("DOMContentLoaded", function(event) {
  $(function() {
    var $previewContainer = $('#post_body-preview-container');
    var $saveButton = $('#saveButton');
    $previewContainer.hide();
    var $md = $("#post_body").markdown({
      autofocus: false,
      height: 270,
      iconlibrary: 'fa',
      onShow: function(e) {
        //e.hideButtons('cmdPreview');
        e.change(e);
      },
      onChange: function(e) {
        var content = e.parseContent();
        if (content === '') {
          $previewContainer.hide();
          $saveButton.hide();
        } else {
          $previewContainer.show().find('#post_body-preview').html(content).find('table').addClass('table table-bordered table-striped table-hover');
          $saveButton.show();
        }
      },
      footer: function(e) {
        return '\
            <span class="text-muted">\
              <span data-md-footer-message="err">\
              </span>\
              <span data-md-footer-message="default">\
                Add images by dragging & dropping or \
                <a class="btn-input">\
                  selecting them\
                  <input type="file" multiple="" id="comment-images" />\
                </a>\
              </span>\
              <span data-md-footer-message="loading">\
                Uploading your images...\
              </span>\
            </span>';
      }
    });

    var $mdEditor = $('.md-editor'),
      msgs = {};

    $mdEditor.addClass('rounded')

    $mdEditor.find('[data-md-footer-message]').each(function() {
      msgs[$(this).data('md-footer-message')] = $(this).hide();
    });
    msgs.default.show();
    $mdEditor.filedrop({
      binded_input: $('#comment-images'),
      url: "/file/create",
      fallbackClick: false,
      beforeSend: function(file, i, done) {
        msgs.
        default.hide();
        msgs.err.hide();
        msgs.loading.show();
        done();
      },
      error: function(err, file) {
        switch (err) {
          case 'BrowserNotSupported':
            alert('browser does not support HTML5 drag and drop')
            break;
          case 'FileExtensionNotAllowed':
            // The file extension is not in the specified list 'allowedfileextensions'
            break;
          default:
            break;
        }
        var filename = typeof file !== 'undefined' ? file.name : '';
        msgs.loading.hide();
        msgs.err.show().html('<span class="text-danger"><i class="fa fa-times"></i> Error uploading ' + filename + ' - ' + err + '</span><br />');
      },
      dragOver: function() {
        $(this).addClass('active');
      },
      dragLeave: function() {
        $(this).removeClass('active');
      },
      progressUpdated: function(i, file, progress) {
        msgs.loading.html('<i class="fa fa-refresh fa-spin"></i> Uploading <span class="text-info">' + file.name + '</span>... ' + progress + '%');
      },
      afterAll: function() {
        msgs.
        default.show();
        msgs.loading.hide();
        msgs.err.hide();
      },
      uploadFinished: function(i, file, response, time) {
        $md.val($md.val() + "![" + file.name + `](http://localhost:3000/file/show?name=${file.name})\n`).trigger('change');
      }
    });
  })
});