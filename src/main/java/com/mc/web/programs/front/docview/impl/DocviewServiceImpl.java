package com.mc.web.programs.front.docview.impl;

import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.geom.Rectangle2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.rendering.ImageType;
import org.apache.pdfbox.rendering.PDFRenderer;
import org.apache.poi.hslf.usermodel.SlideShow;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.xslf.usermodel.XMLSlideShow;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mc.web.MCMap;
import com.mc.web.programs.front.docview.DocviewDAO;
import com.mc.web.programs.front.docview.DocviewService;
import com.mc.web.service.Globals;

import egovframework.com.cmm.util.EgovHttpRequestHelper;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("DocviewService")
public class DocviewServiceImpl extends EgovAbstractServiceImpl implements DocviewService{
	
	@Autowired
	private DocviewDAO dao;

	public String preview(Map<String, String> params) throws IOException, InvalidFormatException {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		MCMap map = dao.getArticle(params);
		
		int idx = map.getStrNull("attach_nm").lastIndexOf(".");
		String extenstion = map.getStrNull("attach_nm").substring(idx+1).toLowerCase();
		map.put("extenstion", extenstion);
		String path = request.getSession().getServletContext().getRealPath(Globals.FILE_PATH) + File.separator + map.getStrNull("yyyy") + File.separator + map.getStrNull("mm");
		File file = new File(path, map.getStrNull("uuid"));
		if(!file.isFile()){
	    	request.setAttribute("message", "파일이 존재하지 않습니다.");
	    	request.setAttribute("redirect", "close");
			return "message";
		}
		if("pdf".equals(extenstion)){
			PDDocument pdfDocument = null;
			try{
				pdfDocument = PDDocument.load(file);
				if(pdfDocument.isEncrypted()){
			    	request.setAttribute("message", "암호화 된 파일은 미리보기가 불가능 합니다.");
			    	request.setAttribute("redirect", "close");
					return "message";
				}
				map.put("page_count", pdfDocument.getNumberOfPages());
			}catch(Exception e){
		    	request.setAttribute("message", "지원하지 않는 파일입니다. 다운로드하여 보시기 바랍니다.");
		    	request.setAttribute("redirect", "close");
				return "message";
			}finally {
				try{
					pdfDocument.close();
				}catch(Exception e){
			    	request.setAttribute("message", "지원하지 않는 파일입니다. 다운로드하여 보시기 바랍니다.");
			    	request.setAttribute("redirect", "close");
					return "message";
				}
			}
		}else if("ppt".equals(extenstion)){
			FileInputStream fis = new FileInputStream(file);
			SlideShow ppt = new SlideShow(fis);
			map.put("page_count", ppt.getSlides().length);
		}else if("pptx".equals(extenstion)){
			XMLSlideShow ppt = new XMLSlideShow(OPCPackage.open(file));
			map.put("page_count", ppt.getSlides().length);
		}
		
		request.setAttribute("item", map);
		return "docview/preview";
	}

	public void page(HttpServletResponse response, Map<String, String> params) throws IOException, InvalidFormatException {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		String path = request.getSession().getServletContext().getRealPath(Globals.FILE_PATH) + File.separator + params.get("path");
		File file = new File(path);
		
		if("pdf".equals(params.get("extenstion"))){
			PDDocument pdfDocument = null;
			try{
				pdfDocument = PDDocument.load(file);
				PDFRenderer pdfRenderer = new PDFRenderer(pdfDocument);
				BufferedImage bi = pdfRenderer.renderImageWithDPI(Integer.parseInt(params.get("page"))-1, 72, ImageType.RGB);
				ImageIO.write(bi, "png", response.getOutputStream());
			}catch(IOException e){
				e.printStackTrace();
			}finally {
				pdfDocument.close();
			}
		}else if("ppt".equals(params.get("extenstion"))){
			SlideShow ppt = new SlideShow(new FileInputStream(file));
			Dimension pgsize = ppt.getPageSize();
			
			int wi = (int) pgsize.getWidth();
			int hei = (int) pgsize.getHeight();
			
			BufferedImage img = new BufferedImage(wi, hei, BufferedImage.TYPE_INT_RGB);

			Graphics2D g2 = img.createGraphics();
			g2.fill(new Rectangle2D.Float(0, 0, wi, hei));
            // default rendering options
            g2.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
            g2.setRenderingHint(RenderingHints.KEY_RENDERING, RenderingHints.VALUE_RENDER_QUALITY);
            g2.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BICUBIC);
            g2.setRenderingHint(RenderingHints.KEY_FRACTIONALMETRICS, RenderingHints.VALUE_FRACTIONALMETRICS_ON);

            g2.setColor(Color.white);
            g2.clearRect(0, 0, wi, hei);

			// render
			ppt.getSlides()[Integer.parseInt(params.get("page"))-1].draw(g2);

			// save the output
			ImageIO.write(img, "png", response.getOutputStream());
		}else if("pptx".equals(params.get("extenstion"))){
			XMLSlideShow ppt = new XMLSlideShow(OPCPackage.open(file));
			Dimension pgsize = ppt.getPageSize();
			
			int wi = (int) pgsize.getWidth();
			int hei = (int) pgsize.getHeight();
			
			BufferedImage img = new BufferedImage(wi, hei, BufferedImage.TYPE_INT_RGB);

			Graphics2D g2 = img.createGraphics();
			g2.fill(new Rectangle2D.Float(0, 0, wi, hei));
            // default rendering options
            g2.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
            g2.setRenderingHint(RenderingHints.KEY_RENDERING, RenderingHints.VALUE_RENDER_QUALITY);
            g2.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BICUBIC);
            g2.setRenderingHint(RenderingHints.KEY_FRACTIONALMETRICS, RenderingHints.VALUE_FRACTIONALMETRICS_ON);

            g2.setColor(Color.white);
            g2.clearRect(0, 0, wi, hei);

			// render
			ppt.getSlides()[Integer.parseInt(params.get("page"))-1].draw(g2);

			// save the output
			ImageIO.write(img, "png", response.getOutputStream());
		}
	}
}