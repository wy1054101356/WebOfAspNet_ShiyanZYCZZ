/*******************************************************************************
* KindEditor - WYSIWYG HTML Editor for Internet
* Copyright (C) 2006-2011 kindsoft.net
*
* @author Roddy <luolonghao@gmail.com>
* @site http://www.kindsoft.net/
* @licence http://www.kindsoft.net/license.php
*******************************************************************************/

KindEditor.plugin('insertfile', function(K) {
	var self = this, name = 'insertfile',
		allowFileUpload = K.undef(self.allowFileUpload, true),
		allowFileManager = K.undef(self.allowFileManager, false),
		formatUploadUrl = K.undef(self.formatUploadUrl, true),
		uploadJson = K.undef(self.uploadJson, self.basePath + 'php/upload_json.php'),
		extraParams = K.undef(self.extraFileUploadParams, {}),
		filePostName = K.undef(self.filePostName, 'imgFile'),
		lang = self.lang(name + '.');
	self.plugin.fileDialog = function(options) {
		var fileUrl = K.undef(options.fileUrl, 'http://'),
			fileTitle = K.undef(options.fileTitle, ''),
			clickFn = options.clickFn;
		var html = [
			'<div style="padding:20px;">',
			'<div class="ke-dialog-row">',
			'<label for="keUrl" style="width:60px;">' + lang.url + '</label>',
			'<input type="text" id="keUrl" name="url" class="ke-input-text" style="width:160px;" /> &nbsp;',
			'<input type="button" class="ke-upload-button" value="' + lang.upload + '" /> &nbsp;',
			'<span class="ke-button-common ke-button-outer">',
			'<input type="button" class="ke-button-common ke-button" name="viewServer" value="' + lang.viewServer + '" />',
			'</span>',
			'</div>',
			//title
			'<div class="ke-dialog-row">',
			'<label for="keTitle" style="width:60px;">' + lang.title + '</label>',
			'<input type="text" id="keTitle" class="ke-input-text" name="title" value="" style="width:160px;" /></div>',
			'</div>',
			//form end
			'</form>',
			'</div>'
			].join('');
		var dialog = self.createDialog({
			name : name,
			width : 450,
			title : self.lang(name),
			body : html,
			yesBtn : {
				name : self.lang('yes'),
				click : function(e) {
					var url = K.trim(urlBox.val()),
						title = titleBox.val();
					if (url == 'http://' || K.invalidUrl(url)) {
						alert(self.lang('invalidUrl'));
						urlBox[0].focus();
						return;
					}
					if (K.trim(title) === '') {
						title = url;
					}
					clickFn.call(self, url, title);
				}
			}
		}),
		div = dialog.div;

		var urlBox = K('[name="url"]', div),
			viewServerBtn = K('[name="viewServer"]', div),
			titleBox = K('[name="title"]', div);

		if (allowFileUpload) {
			var uploadbutton = K.uploadbutton({
				button : K('.ke-upload-button', div)[0],
				fieldName : filePostName,
				url : K.addParam(uploadJson, 'dir=file'),
				extraParams : extraParams,
				afterUpload : function(data) {
					dialog.hideLoading();
					if (data.error === 0) {
						var url = data.url;
						if (formatUploadUrl) {
							url = K.formatUrl(url, 'absolute');
						}
						urlBox.val(url);
						if (self.afterUpload) {
							self.afterUpload.call(self, url, data, name);
						}
						alert(self.lang('uploadSuccess'));
					} else {
						alert(data.message);
					}
				},
				afterError : function(html) {
					dialog.hideLoading();
					self.errorDialog(html);
				}
			});
			uploadbutton.fileBox.change(function(e) {
				dialog.showLoading(self.lang('uploadLoading'));
				uploadbutton.submit();
			});
		} else {
			K('.ke-upload-button', div).hide();
		}
		if (allowFileManager) {
			viewServerBtn.click(function(e) {
				self.loadPlugin('filemanager', function() {
					self.plugin.filemanagerDialog({
						viewType : 'VIEW',
						dirName : 'file',
						clickFn : function(url, title) {
							if (self.dialogs.length > 1) {
								K('[name="url"]', div).val(url);
								if (self.afterSelectFile) {
									self.afterSelectFile.call(self, url);
								}
								self.hideDialog();
							}
						}
					});
				});
			});
		} else {
			viewServerBtn.hide();
		}
		urlBox.val(fileUrl);
		titleBox.val(fileTitle);
		urlBox[0].focus();
		urlBox[0].select();
	};
	self.clickToolbar(name, function() {
		self.plugin.fileDialog({
			clickFn : function(url, title) {
                var stype=url.substring(url.lastIndexOf('.')+1,url.length);//get houzui
                var oLink_type;
                switch(stype)
                {
		case 'bmp':
                   oLink_type="background:url(/e/images/icon/bmp.gif) no-repeat;padding-left:19px";
		break;
		case 'png':
                   oLink_type="background:url(/e/images/icon/png.gif) no-repeat;padding-left:19px";
		break;
		 case 'ppt':
                   oLink_type="background:url(/e/images/icon/ppt.gif) no-repeat;padding-left:19px";
		break;
		case 'jpg':
                   oLink_type="background:url(/e/images/icon/jpg.gif) no-repeat;padding-left:19px";
		break;
		case 'jpeg':
                   oLink_type="background:url(/e/images/icon/jpg.gif) no-repeat;padding-left:19px";
		break;
		case 'gif':
                   oLink_type="background:url(/e/images/icon/gif.gif) no-repeat;padding-left:19px";
		break;
		case 'doc':
                   oLink_type="background:url(/e/images/icon/doc.gif) no-repeat;padding-left:19px";
		break;
		 case 'docx':
                   oLink_type="background:url(/e/images/icon/doc.gif) no-repeat;padding-left:19px";
		 break;
		case 'xls':
                  oLink_type="background:url(/e/images/icon/xls.gif) no-repeat;padding-left:19px";
		break;
		case 'mdb':
                   oLink_type="background:url(/e/images/icon/mdb.gif) no-repeat;padding-left:19px";
		break;
		case 'pdf':
                   oLink_type="background:url(/e/images/icon/pdf.gif) no-repeat;padding-left:19px";
		break;
		case 'js':
                   oLink_type="background:url(/e/images/icon/js.gif) no-repeat;padding-left:19px";
		break;
		case 'mdb':
                   oLink_type="background:url(/e/images/icon/mdb.gif) no-repeat;padding-left:19px";
		break;
		case 'swf':
                   oLink_type="background:url(/e/images/icon/swf.gif) no-repeat;padding-left:19px";
		break;
		case 'rar':
                   oLink_type="background:url(/e/images/icon/rar.gif) no-repeat;padding-left:19px";
		break;
		case 'zip':
                   oLink_type="background:url(/e/images/icon/zip.gif) no-repeat;padding-left:19px";
		break;
		default:
                   oLink_type="";
		break;
                }
               if(oLink_type!="")
                 {
                  oLink_type=" style=\""+oLink_type+"\" ";
                 }
                title=title.substring(title.lastIndexOf('/')+1,title.length);//��ȡ�ļ���

				var html = '<a class="ke-insertfile" href="' + url + '" data-ke-src="' + url + '"'+oLink_type+'target="_blank">' + title + '</a>';
				self.insertHtml(html).hideDialog().focus();
			}
		});
	});
});
