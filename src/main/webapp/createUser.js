const tableContainers = Array.from(document.getElementsByClassName("table-container"));

tableContainers.forEach(function(tableContainer) {
    const tableData = Array.from({ length: 4 }); // 4개의 행 생성을 위한 배열 생성

    const table = document.createElement("table");

    tableData.forEach(function(_, rowIndex) {
      const row = document.createElement("tr");

      for (let i = 1; i <= 2; i++) {
        const cell = document.createElement("td");

        if (i === 2) {
          if (rowIndex === 0) {
            cell.setAttribute("rowspan", tableData.length.toString());
          } else {
            cell.style.display = "none"; // 비어있는 셀은 보이지 않도록 처리
          }
        }

        row.appendChild(cell);
      }

      table.appendChild(row);
    });

    tableContainer.appendChild(table);
  });

