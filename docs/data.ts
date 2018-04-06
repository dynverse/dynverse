"use strict";

document.addEventListener('DOMContentLoaded', function () {
    d3.xml("./overview_evaluation_expanded_v2.svg").then(function(xml) {
        document.getElementById("main").appendChild(xml.documentElement)

        d3.csv("./hovers.csv").then(function(hover_data) {
            var overview_boxes = d3
                .select("g#hover_boxes")
                .selectAll("rect")
                .data(hover_data)
                .classed("clickable", true)
                .style("opacity", 0)

            overview_boxes.on("click", function() {
                var url = d3.select(this).data()[0]["url"]
                window.location.href = url
            })

            overview_boxes.on("mouseover", function() {
                var url = d3.select(this).style("opacity", 1)
            })
            overview_boxes.on("mouseout", function() {
                var url = d3.select(this).style("opacity", 0)
            })

        })
    })
})
