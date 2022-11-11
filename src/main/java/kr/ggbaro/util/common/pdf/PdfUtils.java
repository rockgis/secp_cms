package kr.ggbaro.util.common.pdf;


import com.spire.pdf.*;
import com.spire.pdf.exporting.PdfImageInfo;
import com.spire.pdf.graphics.PdfBitmap;

import java.io.IOException;

/**
 *
 * @Description : pdf 관련 Util
 * @ClassName   : com.mc.web.programs.common.pdf.PdfUtils.java
 * @Modification Information
 *
 * @author LLH
 * @since 2022. 11. 01.
 * @version 1.0 *
 * Copyright (C)  All right reserved.
 */


public class PdfUtils {

    /**
     * @Description : pdf 압축 Util
     *
     */
    public static String CompressPdf(String FileName) throws IOException {

        String outputPdf = FileName;

        //Create a PdfDocument object
        PdfDocument doc = new PdfDocument();
        //Load a PDF file
        doc.loadFromFile("C:\\Users\\Administrator\\Desktop\\Document\\PDF\\"+FileName);

        //Disable incremental update
        doc.getFileInfo().setIncrementalUpdate(false);
        //Set the compression level to best

        doc.setCompressionLevel(PdfCompressionLevel.Best);

        //Loop through the pages in the document
        for (int i = 0; i < doc.getPages().getCount(); i++) {
            //Get a specific page
            PdfPageBase page = doc.getPages().get(i);
            //Get image information collection from the page

            PdfImageInfo[] images = page.getImagesInfo();

            //Traverse the items in the collection

            if (images != null && images.length > 0)

                for (int j = 0; j < images.length; j++) {
                    //Get a specific image
                    PdfImageInfo image = images[j];
                    PdfBitmap bp = new PdfBitmap(image.getImage());
                    //Set the compression quality
                    bp.setQuality(20);

                    //Replace the original image with the compressed one
                    page.replaceImage(j, bp);

                }
            //Save the document to a PDF file

            doc.saveToFile("output/" + outputPdf);
            doc.close();
        }

        return outputPdf;
    }

    /**
     * @Description : pdf Merge Util
     *
     */
    public static void MergePdfs(String[] FileName, String outputPdf ) throws IOException {

        //Get the paths of the documents to be merged
        String[] files = new String[] {
                "C:\\Users\\Administrator\\Desktop\\PDFs\\sample-1.pdf",
                "C:\\Users\\Administrator\\Desktop\\PDFs\\sample-2.pdf",
                "C:\\Users\\Administrator\\Desktop\\PDFs\\sample-3.pdf"};
        //Merge these documents and return an object of PdfDocumentBase

        PdfDocumentBase doc = PdfDocument.mergeFiles(FileName);
        //Save the result to a PDF file
        doc.save(outputPdf, FileFormat.PDF);
    }

}

