import 'package:flutter/material.dart';

List<Widget> buildPaginationNumbers({
    required int currentPage,
    required int totalPages,
    required Function(int) onPageSelected,
  }) {
    List<Widget> items = [];

    void addPageNumber(int pageNum) {
      items.add(
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          child: InkWell(
            onTap: () => onPageSelected(pageNum),
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                border: Border.all(
                  color:
                      currentPage == pageNum ? Colors.blue : Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              alignment: Alignment.center,
              child: Text(
                '$pageNum',
                style: TextStyle(
                  color: currentPage == pageNum ? Colors.blue : Colors.black,
                  fontWeight: currentPage == pageNum
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
      );
    }

    void addEllipsis() {
      items.add(
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          child: const Text('...'),
        ),
      );
    }

    // Always show first page
    addPageNumber(1);

    if (currentPage > 3) {
      addEllipsis();
    }

    // Show pages around current page
    for (int i = currentPage - 1; i <= currentPage + 1; i++) {
      if (i > 1 && i < totalPages) {
        addPageNumber(i);
      }
    }

    if (currentPage < totalPages - 2) {
      addEllipsis();
    }

    // Always show last page
    if (totalPages > 1) {
      addPageNumber(totalPages);
    }

    return items;
  }