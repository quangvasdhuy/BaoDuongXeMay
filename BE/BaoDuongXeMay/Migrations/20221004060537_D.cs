using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace BaoDuongXeMay.Migrations
{
    public partial class D : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "DetailNAU",
                columns: table => new
                {
                    AccessaryID = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    UnitID = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    VehicleID = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    Km_Min = table.Column<int>(type: "int", nullable: false),
                    Km_Max = table.Column<int>(type: "int", nullable: false),
                    CountPerforation = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DetailNAU", x => new { x.AccessaryID, x.UnitID, x.VehicleID });
                    table.ForeignKey(
                        name: "FK_Accessary_DetailNaus",
                        column: x => x.AccessaryID,
                        principalTable: "Accessaries",
                        principalColumn: "AccessaryID",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Unit_DetailNaus",
                        column: x => x.UnitID,
                        principalTable: "Units",
                        principalColumn: "UnitID",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Vehicle_DetailNaus",
                        column: x => x.VehicleID,
                        principalTable: "Vehicle",
                        principalColumn: "VehicleID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_DetailNAU_UnitID",
                table: "DetailNAU",
                column: "UnitID");

            migrationBuilder.CreateIndex(
                name: "IX_DetailNAU_VehicleID",
                table: "DetailNAU",
                column: "VehicleID");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "DetailNAU");
        }
    }
}
