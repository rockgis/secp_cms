package kr.ggbaro.util.common.execl;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.spire.xls.FileFormat;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.*;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.stream.Collectors;


public class ExeclUtils {



    public static List<Map> readExcelFile(String filePath) {

        try {
            FileInputStream excelFile = new FileInputStream(new File(filePath));
            Workbook workbook = new XSSFWorkbook(excelFile);

            Sheet sheet = workbook.getSheetAt(0);
            Iterator<Row> rows = sheet.iterator();
            List<Map> lstProducts = new ArrayList<Map>();

            int rowNumber = 0;
            while (rows.hasNext()) {
                Row currentRow = rows.next();

                // skip header
                if (rowNumber == 0) {
                    rowNumber++;
                    continue;
                }

                Iterator<Cell> cellsInRow = currentRow.iterator();

                HashMap<String, String> map = new HashMap<String, String>();


                int cellIndex = 0;
                while (cellsInRow.hasNext()) {
                    Cell currentCell = cellsInRow.next();

                    map.put(String.valueOf(cellIndex),String.valueOf(currentCell.getNumericCellValue()));

                    cellIndex++;
                }
                lstProducts.add(map);
            }
            return lstProducts;

        } catch (IOException e) {
            throw new RuntimeException("message = " + e.getMessage());
        }
    }


    static <T> Collection<List<T>> partitionBasedOnSize(List<T> inputList, int size) {
        final AtomicInteger counter = new AtomicInteger(0);
        return inputList.stream().collect(Collectors.groupingBy(s -> counter.getAndIncrement() / size)).values();
    }

    public static Map<String, Map<String, List<Map>>> pagingData(List<Map> products) {
        Map<String, Map<String, List<Map>>> actualProduct = new LinkedHashMap<>();
        Collection<List<Map>> c = partitionBasedOnSize(products, 3);
        System.out.println(c);
        int i = 1;
        Map<String, List<Map>> productMap = new LinkedHashMap<>();
        for (List<Map> list : c) {
            productMap.put("product" + i, list);
            i++;
        }
        actualProduct.put("page", productMap);
        return actualProduct;
    }

    public static String convertObjects2JsonString(Map<String, Map<String, List<Map>>> products) {
        ObjectMapper mapper = new ObjectMapper();
        String jsonString = "";
        try {
            jsonString = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(products);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }

        return jsonString;
    }



}

