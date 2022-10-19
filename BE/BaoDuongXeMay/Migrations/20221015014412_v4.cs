using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace BaoDuongXeMay.Migrations
{
    public partial class v4 : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_DetailVehicle_User_DetailNAU_DetaillNAUIDDetailNAU",
                table: "DetailVehicle_User");

            migrationBuilder.DropIndex(
                name: "IX_DetailVehicle_User_DetaillNAUIDDetailNAU",
                table: "DetailVehicle_User");

            migrationBuilder.DropColumn(
                name: "DetaillNAUIDDetailNAU",
                table: "DetailVehicle_User");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<Guid>(
                name: "DetaillNAUIDDetailNAU",
                table: "DetailVehicle_User",
                type: "uniqueidentifier",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_DetailVehicle_User_DetaillNAUIDDetailNAU",
                table: "DetailVehicle_User",
                column: "DetaillNAUIDDetailNAU");

            migrationBuilder.AddForeignKey(
                name: "FK_DetailVehicle_User_DetailNAU_DetaillNAUIDDetailNAU",
                table: "DetailVehicle_User",
                column: "DetaillNAUIDDetailNAU",
                principalTable: "DetailNAU",
                principalColumn: "IDDetailNAU",
                onDelete: ReferentialAction.Restrict);
        }
    }
}
